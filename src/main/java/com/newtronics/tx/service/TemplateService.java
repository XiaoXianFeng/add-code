package com.newtronics.tx.service;

import java.util.List;

import com.newtronics.tx.model.Template;

public interface TemplateService {
	List<Template> findAllTemplates();
	
	List<Template> findAllTemplatesByCreator(String username);

	Template findTemplateById(String templateId);

	Template findTemplateById(String templateId, boolean includeDisabled);
	
	void insertTemplate(Template template) throws Exception;

	Template updateTemplate(Template template) throws Exception;
}
