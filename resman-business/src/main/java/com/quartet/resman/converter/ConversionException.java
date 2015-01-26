package com.quartet.resman.converter;

public class ConversionException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public ConversionException() {
		super();
	}

	public ConversionException(String arg0) {
		super(arg0);
	}

	public ConversionException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public ConversionException(Throwable arg0) {
		super(arg0);
	}
}
