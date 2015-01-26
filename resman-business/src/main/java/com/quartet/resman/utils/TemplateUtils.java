package com.quartet.resman.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class TemplateUtils {
    private static Logger log = LoggerFactory.getLogger(TemplateUtils.class);
    private static Configuration cfg = null;

    /**
     * Singleton FreeMaker configuration
     */
    public static synchronized Configuration getConfig() {
        if (cfg == null) {
            cfg = new Configuration();
            cfg.setObjectWrapper(new DefaultObjectWrapper());
        }

        return cfg;
    }

    /**
     * Check for template existence
     */
    public static boolean templateExists(String name) {
        try {
            getConfig().getTemplate(name);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    /**
     * Quick replace utility function
     */
    public static String replace(String name, String template, Map<String, Object> model) throws
            IOException, TemplateException {
        StringReader sr = new StringReader(template);
        Template tpl = new Template(name, sr, cfg);
        StringWriter sw = new StringWriter();
        tpl.process(model, sw);
        sw.close();
        sr.close();
        return sw.toString();
    }

    /**
     * Quick replace utility function
     */
    public static void replace(String name, InputStream input, Map<String, Object> model,
                               OutputStream out) throws IOException, TemplateException {
        InputStreamReader isr = new InputStreamReader(input);
        Template tpl = new Template(name, isr, cfg);
        OutputStreamWriter osw = new OutputStreamWriter(out);
        tpl.process(model, osw);
        osw.close();
        isr.close();
    }
}
