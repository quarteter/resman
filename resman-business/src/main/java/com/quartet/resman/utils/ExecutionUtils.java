package com.quartet.resman.utils;

import java.io.*;
import java.util.Arrays;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

import com.quartet.resman.converter.StreamProcessor;
import com.quartet.resman.entity.ExecutionResult;
import com.quartet.resman.service.Config;
import com.quartet.resman.utils.cl.BinaryClassLoader;
import com.quartet.resman.utils.cl.ClassLoaderUtils;
import com.quartet.resman.utils.cl.JarClassLoader;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import bsh.EvalError;
import bsh.Interpreter;


public class ExecutionUtils {
	private static Logger log = LoggerFactory.getLogger(ExecutionUtils.class);
	private static ExecutionUtils single = new ExecutionUtils();
	
	private ExecutionUtils() {
	}
	
	public static ExecutionUtils getInstance() {
		return single;
	}
	
	/**
	 * Execute script from file
	 * 
	 * @return 0 - Return
	 *         1 - StdOut
	 *         2 - StdErr
	 */
	public static Object[] runScript(File script) throws EvalError {
		Object[] ret = new Object[3];
		FileReader fr = null;
		
		try {
			if (script.exists() && script.canRead()) {
				ByteArrayOutputStream baosOut = new ByteArrayOutputStream();
				PrintStream out = new PrintStream(baosOut);
				ByteArrayOutputStream baosErr = new ByteArrayOutputStream();
				PrintStream err = new PrintStream(baosErr);
				Interpreter i = new Interpreter(null, out, err, false);
				fr = new FileReader(script);
				
				ret[0] = i.eval(fr);
				
				out.flush();
				ret[1] = baosOut.toString();
				err.flush();
				ret[2] = baosErr.toString();
			} else {
				log.warn("Unable to read script: {}", script.getPath());
			}
		} catch (IOException e) {
			log.warn(e.getMessage(), e);
		} finally {
			IOUtils.closeQuietly(fr);
		}
		
		log.debug("runScript: {}", Arrays.toString(ret));
		return ret;
	}
	
	/**
	 * Execute script
	 * 
	 * @return 0 - Return
	 *         1 - StdOut
	 *         2 - StdErr
	 */
	public static Object[] runScript(String script) throws EvalError {
		Object[] ret = new Object[3];
		ByteArrayOutputStream baosOut = new ByteArrayOutputStream();
		PrintStream out = new PrintStream(baosOut);
		ByteArrayOutputStream baosErr = new ByteArrayOutputStream();
		PrintStream err = new PrintStream(baosErr);
		Interpreter i = new Interpreter(null, out, err, false);
		
		ret[0] = i.eval(script);
		
		out.flush();
		ret[1] = baosOut.toString();
		
		err.flush();
		ret[2] = baosErr.toString();
		
		log.debug("runScript: {}", Arrays.toString(ret));
		return ret;
	}
	
	/**
	 * Execute jar from file
	 */
	public Object runJar(File jar) {
		Object ret = null;
		
		try {
			if (jar.exists() && jar.canRead()) {
				ClassLoader cl = getClass().getClassLoader();
				JarClassLoader jcl = new JarClassLoader(jar.toURI().toURL(), cl);
				String mainClass = jcl.getMainClassName();
				
				if (mainClass != null) {
					Class<?> c = jcl.loadClass(mainClass);
					ret = ClassLoaderUtils.invokeMainMethodFromClass(c, new String[]{});
				} else {
					log.error("Main class not defined at: {}", jar.getPath());
				}
			} else {
				log.warn("Unable to read jar: {}", jar.getPath());
			}
		} catch (Exception e) {
			log.warn(e.getMessage(), e);
		}
		
		log.debug("runJar: {}", ret != null ? ret.toString() : "null");
		return ret;
	}
	
	/**
	 * Execute jar from file
	 */
	public Object runJar(File jar, String methodName) {
		Object ret = null;
		
		try {
			if (jar.exists() && jar.canRead()) {
				ClassLoader cl = getClass().getClassLoader();
				JarClassLoader jcl = new JarClassLoader(jar.toURI().toURL(), cl);
				String mainClass = jcl.getMainClassName();
				
				if (mainClass != null) {
					Class<?> c = jcl.loadClass(mainClass);
					ret = ClassLoaderUtils.invokeMethodFromClass(c, methodName);
				} else {
					log.error("Main class not defined at: {}", jar.getPath());
				}
			} else {
				log.warn("Unable to read jar: {}", jar.getPath());
			}
		} catch (Exception e) {
			log.warn(e.getMessage(), e);
		}
		
		log.debug("runJar: {}", ret != null ? ret.toString() : "null");
		return ret;
	}
	
	/**
	 * Execute jar
	 */
	public Object runJar(byte[] jar) {
		Object ret = null;
		
		try {
			ClassLoader cl = getClass().getClassLoader();
			BinaryClassLoader jcl = new BinaryClassLoader(jar, cl);
			String mainClass = jcl.getMainClassName();
			
			if (mainClass != null) {
				Class<?> c = jcl.loadClass(mainClass);
				ret = ClassLoaderUtils.invokeMainMethodFromClass(c, new String[] {});
			} else {
				log.error("Main class not defined at jar");
			}
		} catch (Exception e) {
			log.warn(e.getMessage(), e);
		}
		
		log.debug("runJar: {}", ret != null ? ret.toString() : "null");
		return ret;
	}
	
	/**
	 * Execute jar
	 */
	public Object runJar(byte[] jar, String methodName) {
		Object ret = null;
		
		try {
			ClassLoader cl = getClass().getClassLoader();
			BinaryClassLoader jcl = new BinaryClassLoader(jar, cl);
			String mainClass = jcl.getMainClassName();
			
			if (mainClass != null) {
				Class<?> c = jcl.loadClass(mainClass);
				ret = ClassLoaderUtils.invokeMethodFromClass(c, methodName);
			} else {
				log.error("Main class not defined at jar");
			}
		} catch (Exception e) {
			log.warn(e.getMessage(), e);
		}
		
		log.debug("runJar: {}", ret != null ? ret.toString() : "null");
		return ret;
	}
	
	/**
	 * Execute command line
	 */
	public static ExecutionResult runCmd(String cmd) throws SecurityException, InterruptedException, IOException {
		log.debug("runCmd({})", cmd);
		return runCmdImpl(cmd.split(" "), TimeUnit.MINUTES.toMillis(Config.SYSTEM_EXECUTION_TIMEOUT));
	}

	public static ExecutionResult runCmd(String cmd,int timeOutMinutes) throws SecurityException, InterruptedException, IOException{
		return runCmdImpl1(cmd.split(" "), TimeUnit.MINUTES.toMillis(timeOutMinutes));
	}
	
	/**
	 * Execute command line
	 */
	public static ExecutionResult runCmd(String cmd[]) throws SecurityException, InterruptedException, IOException {
		log.debug("runCmd({})", Arrays.toString(cmd));
		return runCmdImpl(cmd, TimeUnit.MINUTES.toMillis(Config.SYSTEM_EXECUTION_TIMEOUT));
	}
	
	/**
	 * Execute command line: implementation
	 */
	private static ExecutionResult runCmdImpl(final String cmd[], final long timeout) throws SecurityException,
			InterruptedException, IOException {
		log.debug("runCmdImpl({}, {})", Arrays.toString(cmd), timeout);
		ExecutionResult ret = new ExecutionResult();
		long start = System.currentTimeMillis();
		final ProcessBuilder pb = new ProcessBuilder(cmd);
		final Process process = pb.start();
		
		Timer t = new Timer("Process Execution Timeout");
		t.schedule(new TimerTask() {
			@Override
			public void run() {
				process.destroy();
				log.warn("Process killed due to timeout.");
				log.warn("CommandLine: {}", Arrays.toString(cmd));
			}
		}, timeout);
		
		try {
			ret.setStdout(IOUtils.toString(process.getInputStream()));
			ret.setStderr(IOUtils.toString(process.getErrorStream()));
		} catch (IOException e) {
			// Ignore
		}
		
		process.waitFor();
		t.cancel();
		ret.setExitValue(process.exitValue());
		
		// Check return code
		if (ret.getExitValue() != 0) {
			log.warn("Abnormal program termination: {}", ret.getExitValue());
			log.warn("CommandLine: {}", Arrays.toString(cmd));
			log.warn("STDERR: {}", ret.getStderr());
		} else {
			log.debug("Normal program termination");
		}
		
		process.destroy();
		log.debug("Elapse time: {}", FormatUtil.formatSeconds(System.currentTimeMillis() - start));
		return ret;
	}

	private static ExecutionResult runCmdImpl1(final String cmd[], final long timeout) throws SecurityException,
			InterruptedException, IOException {
		log.debug("runCmdImpl({}, {})", Arrays.toString(cmd), timeout);
		ExecutionResult ret = new ExecutionResult();
		long start = System.currentTimeMillis();
		final ProcessBuilder pb = new ProcessBuilder(cmd);
		final Process process = pb.redirectErrorStream(true).start();

		Timer t = new Timer("Process Execution Timeout");
		t.schedule(new TimerTask() {
			@Override
			public void run() {
				process.destroy();
				log.warn("Process killed due to timeout.");
				log.warn("CommandLine: {}", Arrays.toString(cmd));
			}
		}, timeout);

		StreamProcessor esp = new StreamProcessor(process.getErrorStream(),false,"error");
		StreamProcessor isp = new StreamProcessor(process.getInputStream(),false,"info");
		esp.process();
		isp.process();

		process.waitFor();
		t.cancel();
		ret.setExitValue(process.exitValue());

		// Check return code
		if (ret.getExitValue() != 0) {
			log.warn("Abnormal program termination: {}", ret.getExitValue());
			log.warn("CommandLine: {}", Arrays.toString(cmd));
			log.warn("STDERR: {}", ret.getStderr());
		} else {
			log.debug("Normal program termination");
		}

		process.destroy();
		log.debug("Elapse time: {}", FormatUtil.formatSeconds(System.currentTimeMillis() - start));
		return ret;
	}
}
