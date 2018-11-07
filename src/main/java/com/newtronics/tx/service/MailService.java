package com.newtronics.tx.service;

import java.util.Map;

public interface MailService {

	void sendReviewEmail(Map<String, String> model);
}
