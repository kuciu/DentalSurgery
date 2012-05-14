package pl.poznan.put.dentalsurgery.service;

import org.springframework.stereotype.Service;

import pl.poznan.put.dentalsurgery.model.Attachment;
import pl.poznan.put.dentalsurgery.repository.AttachmentDao;

@Service
public class AttachmentServiceImpl implements AttachmentService {

	AttachmentDao attachmentDao;

	@Override
	public Long save(final Attachment attachment) {
		return attachmentDao.addAttachment(attachment);
	}

}
