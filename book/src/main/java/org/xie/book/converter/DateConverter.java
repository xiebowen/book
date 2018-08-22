package org.xie.book.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.core.convert.converter.Converter;

public class DateConverter implements Converter<String, Date> {
	
	Logger logger = Logger.getLogger(DateConverter.class);
	
	@Override
	public Date convert(String source) {
		logger.info("===DateConverter===");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		try {
			return dateFormat.parse(source);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
}