export interface MediaStorage {
  upload(input: MediaUploadInput): Promise<MediaResult>;
  delete(mediaId: string): Promise<void>;
  getUrl(mediaId: string): Promise<string>;
}

export interface MediaUploadInput {
  ownerType: string;
  ownerId: string;
  mediaType: string;
  filename: string;
  data: Buffer | ReadableStream;
  altText?: string;
}

export interface MediaResult {
  id: string;
  url: string;
  mimeType: string;
  sizeBytes: number;
  width?: number;
  height?: number;
  durationSeconds?: number;
}
