package com.newtronics.tx.dao;

import java.util.List;

import com.newtronics.tx.model.Template;

public interface TemplateDao {

	List<Template> findAllTemplates();

	List<Template> findAllTemplatesByCreator(String username);

	Template findTemplateById(String templateId);

	Template findTemplateById(String templateId, boolean includeDisabled);

	void insertTemplate(Template template);

	Template updateTemplate(Template template);
}
