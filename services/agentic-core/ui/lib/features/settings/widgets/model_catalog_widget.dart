import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../services/api_client.dart';
import '../../../theme/agent_studio_theme.dart';

class ModelCatalogWidget extends StatefulWidget {
  const ModelCatalogWidget({super.key, required this.onAddModel});
  final void Function(Map<String, String> provider) onAddModel;

  @override
  State<ModelCatalogWidget> createState() => _ModelCatalogWidgetState();
}

class _ModelCatalogWidgetState extends State<ModelCatalogWidget> {
  static final _log = Logger('ModelCatalogWidget');
  final _api = ApiClient();
  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> _allModels = [];
  List<Map<String, dynamic>> _filteredModels = [];
  bool _loading = true;
  String? _error;
  String _typeFilter = 'all';
  bool _toolCallOnly = true;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_applyFilters);
    _fetchModels();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _fetchModels() async {
    _log.info('Fetching models from backend...');
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final resp = await _api.listModels(toolCallOnly: _toolCallOnly);
      final models = (resp['models'] as List?) ?? [];
      _allModels = models.cast<Map<String, dynamic>>();
      _log.info('Fetched ${_allModels.length} models');
      _applyFilters();
    } catch (e) {
      _log.warning('Failed to fetch models: $e');
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  void _applyFilters() {
    final query = _searchCtrl.text.toLowerCase().trim();
    setState(() {
      _filteredModels = _allModels.where((m) {
        if (_typeFilter != 'all' && m['type'] != _typeFilter) return false;
        if (query.isEmpty) return true;
        final id = (m['id'] as String? ?? '').toLowerCase();
        final name = (m['name'] as String? ?? '').toLowerCase();
        final provider = (m['provider'] as String? ?? '').toLowerCase();
        return id.contains(query) || name.contains(query) || provider.contains(query);
      }).toList();
    });
  }

  void _addModel(Map<String, dynamic> model) {
    final providerName = model['provider'] as String? ?? 'Unknown';
    final modelId = model['id'] as String? ?? '';
    final apiBase = model['api_base'] as String? ?? '';
    final isCloud = model['type'] == 'cloud';

    widget.onAddModel({
      'name': '$providerName (${modelId.split('/').last})',
      'type': 'openai',
      'model': modelId,
      'baseUrl': apiBase.isNotEmpty ? apiBase : (isCloud ? 'https://api.openai.com/v1' : 'http://localhost:11434/v1'),
      'status': 'configured',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Catalogo de Modelos',
              style: TextStyle(color: AgentStudioTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            if (!_loading)
              Text('${_filteredModels.length} modelos',
                style: const TextStyle(color: AgentStudioTheme.textSecondary, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        const Text('Explora modelos disponibles. Agrega cualquier modelo como provider de inferencia.',
          style: TextStyle(color: AgentStudioTheme.textSecondary, fontSize: 12)),
        const SizedBox(height: 12),
        TextField(
          controller: _searchCtrl,
          style: const TextStyle(color: AgentStudioTheme.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'Buscar modelos por nombre, ID o provider...',
            hintStyle: const TextStyle(color: AgentStudioTheme.textSecondary),
            prefixIcon: const Icon(Icons.search, size: 18, color: AgentStudioTheme.textSecondary),
            suffixIcon: _searchCtrl.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 16, color: AgentStudioTheme.textSecondary),
                    onPressed: () {
                      _searchCtrl.clear();
                      _applyFilters();
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ...['all', 'cloud', 'local', 'hybrid'].map((t) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(_typeLabel(t), style: const TextStyle(fontSize: 11)),
                selected: _typeFilter == t,
                onSelected: (_) {
                  setState(() => _typeFilter = t);
                  _applyFilters();
                },
                selectedColor: AgentStudioTheme.primary,
                checkmarkColor: Colors.white,
                backgroundColor: AgentStudioTheme.card,
                side: const BorderSide(color: AgentStudioTheme.border),
                labelStyle: TextStyle(
                  color: _typeFilter == t ? Colors.white : AgentStudioTheme.textPrimary,
                  fontSize: 11,
                ),
                visualDensity: VisualDensity.compact,
              ),
            )),
            const Spacer(),
            SizedBox(
              height: 28,
              child: FilterChip(
                label: const Text('tool_call', style: TextStyle(fontSize: 10)),
                selected: _toolCallOnly,
                onSelected: (v) {
                  setState(() => _toolCallOnly = v);
                  _fetchModels();
                },
                selectedColor: AgentStudioTheme.success.withValues(alpha: 0.3),
                checkmarkColor: AgentStudioTheme.success,
                backgroundColor: AgentStudioTheme.card,
                side: const BorderSide(color: AgentStudioTheme.border),
                labelStyle: TextStyle(
                  color: _toolCallOnly ? AgentStudioTheme.success : AgentStudioTheme.textSecondary,
                  fontSize: 10,
                ),
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              height: 28,
              child: IconButton(
                icon: const Icon(Icons.refresh, size: 16, color: AgentStudioTheme.textSecondary),
                onPressed: _loading ? null : _fetchModels,
                tooltip: 'Refrescar catalogo',
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _buildBody(),
        ),
      ],
    );
  }

  String _typeLabel(String t) => switch (t) {
    'all' => 'Todos',
    'cloud' => '\u2601 Nube',
    'local' => '\u{1F4BB} Local',
    'hybrid' => '\u2601\u{1F4BB} Hibrido',
    _ => t,
  };

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AgentStudioTheme.primary),
            SizedBox(height: 12),
            Text('Cargando catalogo de modelos...',
              style: TextStyle(color: AgentStudioTheme.textSecondary, fontSize: 12)),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 40, color: AgentStudioTheme.error),
            const SizedBox(height: 12),
            const Text('No se pudo cargar el catalogo de modelos',
              style: TextStyle(color: AgentStudioTheme.textPrimary, fontSize: 14)),
            const SizedBox(height: 4),
            Text(_error!, style: const TextStyle(color: AgentStudioTheme.textSecondary, fontSize: 11)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _fetchModels,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Reintentar', style: TextStyle(fontSize: 12)),
              style: FilledButton.styleFrom(backgroundColor: AgentStudioTheme.primary),
            ),
          ],
        ),
      );
    }

    if (_filteredModels.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 40, color: AgentStudioTheme.textSecondary),
            const SizedBox(height: 12),
            Text(
              _searchCtrl.text.isEmpty
                  ? 'No hay modelos disponibles con los filtros seleccionados'
                  : 'No se encontraron modelos para "${_searchCtrl.text}"',
              style: const TextStyle(color: AgentStudioTheme.textSecondary, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredModels.length,
      itemBuilder: (_, i) => _modelCard(_filteredModels[i]),
    );
  }

  Widget _modelCard(Map<String, dynamic> model) {
    final id = model['id'] as String? ?? '';
    final provider = model['provider'] as String? ?? '';
    final name = model['name'] as String? ?? '';
    final type = model['type'] as String? ?? 'cloud';
    final toolCall = model['tool_call'] as bool? ?? false;
    final reasoning = model['reasoning'] as bool? ?? false;
    final openWeights = model['open_weights'] as bool? ?? false;

    final typeColor = switch (type) {
      'local' => AgentStudioTheme.success,
      'hybrid' => AgentStudioTheme.warning,
      _ => AgentStudioTheme.info,
    };
    final typeIcon = switch (type) {
      'local' => '\u{1F4BB}',
      'hybrid' => '\u2601\u{1F4BB}',
      _ => '\u2601',
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AgentStudioTheme.card,
        border: Border.all(color: AgentStudioTheme.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: typeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('$typeIcon $type',
                        style: TextStyle(color: typeColor, fontSize: 9, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(id,
                        style: const TextStyle(color: AgentStudioTheme.textPrimary, fontSize: 12, fontFamily: 'monospace'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(provider,
                  style: const TextStyle(color: AgentStudioTheme.textSecondary, fontSize: 11)),
                const SizedBox(height: 3),
                Text(name,
                  style: const TextStyle(color: AgentStudioTheme.textPrimary, fontSize: 12)),
                if (toolCall || reasoning || openWeights) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: [
                      if (toolCall)
                        _badge('tool_call', AgentStudioTheme.primary),
                      if (reasoning)
                        _badge('reasoning', AgentStudioTheme.warning),
                      if (openWeights)
                        _badge('open-weights', AgentStudioTheme.success),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 28,
            child: FilledButton.icon(
              onPressed: () => _addModel(model),
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Agregar', style: TextStyle(fontSize: 11)),
              style: FilledButton.styleFrom(
                backgroundColor: AgentStudioTheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(text,
        style: TextStyle(color: color, fontSize: 9)),
    );
  }
}
