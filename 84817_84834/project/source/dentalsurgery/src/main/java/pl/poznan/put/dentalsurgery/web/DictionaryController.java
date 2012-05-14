package pl.poznan.put.dentalsurgery.web;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pl.poznan.put.dentalsurgery.service.DictTransferObject;
import pl.poznan.put.dentalsurgery.service.DictionaryService;

@Controller
@RequestMapping({"/dict"})
public class DictionaryController {

	private static final Log LOG = LogFactory.getLog(DictionaryController.class);

	private DictionaryService dictionaryService;

	@Autowired
	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}
	
	/**
	 * Odsyła JSONa, który zawiera wszystkie potrzebne słowniki
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/getall")
	public @ResponseBody DictTransferObject getAllDictionaries(Model model) {
		DictTransferObject dictionaries = dictionaryService.getAllDictionaries();
		return dictionaries;
	}
	
}
