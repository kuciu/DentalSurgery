package pl.poznan.put.dentalsurgery.web;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import pl.poznan.put.dentalsurgery.model.SimpleEntity;
import pl.poznan.put.dentalsurgery.service.SimpleEntityService;

public class SimpleController implements Controller {

	protected final Log logger = LogFactory.getLog(getClass());

	private SimpleEntityService simpleEntityService;
	
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Collection<SimpleEntity> entityList = simpleEntityService.loadAllEntities();
		
        Map<String, Object> myModel = new HashMap<String, Object>();
        myModel.put("entityList", entityList);
        myModel.put("someString", "napis w obiekcie modelu");

        return new ModelAndView("hello", myModel);
	}

	public void setSimpleEntityService(SimpleEntityService simpleEntityService) {
		this.simpleEntityService = simpleEntityService;
	}
	
}
