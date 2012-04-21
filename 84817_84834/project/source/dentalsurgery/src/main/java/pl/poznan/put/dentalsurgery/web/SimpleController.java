package pl.poznan.put.dentalsurgery.web;

import java.util.Collection;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import pl.poznan.put.dentalsurgery.model.SimpleEntity;
import pl.poznan.put.dentalsurgery.service.SimpleEntityService;

@Controller
public class SimpleController {

	protected final Log logger = LogFactory.getLog(getClass());
	private SimpleEntityService simpleEntityService;

	@Autowired
	public void setSimpleEntityService(SimpleEntityService simpleEntityService) {
		this.simpleEntityService = simpleEntityService;
	}

	@RequestMapping({"/","/hello"})
	public String showSomePage(Map<String,Object> model) throws Exception {

		Collection<SimpleEntity> entityList = simpleEntityService
				.loadAllEntities();
		model.put("entityList", entityList);
		model.put("someString", "napis w obiekcie modelu");

		return "hello";
	}

}
