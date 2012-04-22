package pl.poznan.put.dentalsurgery.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import junit.framework.TestCase;

public class SimpleEntityServiceImplTest extends TestCase {
	protected final Log logger = LogFactory.getLog(getClass());

	SimpleEntityService service;
	
	public void setUp() throws Exception {
		service = new SimpleEntityServiceImpl();
	}

	public void testLoadAllEntities() {
		
		logger.info("OK!!!");
	}

}
