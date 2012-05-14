package pl.poznan.put.dentalsurgery.model;

public class Attachment {
	private long attachmentId;
	private Visit visit;
	private String fileName;
	private String description;
	private byte[] file;

	public long getAttachmentId() {
		return attachmentId;
	}

	public void setAttachmentId(final long attachmentId) {
		this.attachmentId = attachmentId;
	}

	public Visit getVisit() {
		return visit;
	}

	public void setVisit(final Visit visit) {
		this.visit = visit;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(final String fileName) {
		this.fileName = fileName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(final String description) {
		this.description = description;
	}

	public byte[] getFile() {
		return file;
	}

	public void setFile(final byte[] file) {
		this.file = file;
	}
}
