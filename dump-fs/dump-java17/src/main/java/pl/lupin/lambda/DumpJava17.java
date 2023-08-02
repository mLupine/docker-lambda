package pl.lupin.lambda;

import java.io.File;
import java.io.IOException;
import java.lang.InterruptedException;
import java.lang.management.ManagementFactory;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Scanner;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;
import com.amazonaws.services.lambda.runtime.Context;

public class DumpJava17 {
    public PutObjectResult handle(Object input, Context context, String arch) {
        String filename = "java17-" + arch + ".tgz";
        String cmd = "touch /tmp/" + filename + " && tar -cpzf /tmp/" + filename + " --numeric-owner --ignore-failed-read /var/runtime /var/lang";
        AmazonS3 s3client = AmazonS3ClientBuilder.standard().withRegion("eu-central-1").build();

        System.out.println(ManagementFactory.getRuntimeMXBean().getInputArguments().toString());
        System.out.println(System.getProperty("sun.java.command"));
        System.out.println(System.getProperty("java.home"));
        System.out.println(System.getProperty("java.library.path"));
        System.out.println(System.getProperty("java.class.path"));
        System.out.println(System.getProperty("user.dir"));
        System.out.println(System.getProperty("user.home"));
        System.out.println(System.getProperty("user.name"));
        System.out.println(new File(".").getAbsolutePath());
        Map<String, String> env = System.getenv();
        for (String envName : env.keySet()) {
            System.out.println(envName + "=" + env.get(envName));
        }

        try {
            int pid = Integer.parseInt(new File("/proc/self").getCanonicalFile().getName());

            System.out.println("Parent cmdline:");
            System.out.println(new String(Files.readAllBytes(Paths.get("/proc/1/cmdline"))).replace("\0", " "));

            System.out.println("Parent env:");
            runShell("xargs --null --max-args=1 < /proc/1/environ");

            System.out.println("This cmdline:");
            System.out.println(new String(Files.readAllBytes(Paths.get("/proc/" + pid + "/cmdline"))).replace("\0", " "));

            System.out.println("This env:");
            runShell("xargs --null --max-args=1 < /proc/" + pid + "/environ");

            if (runShell(cmd) != 0) {
                return null;
            }

            System.out.println("Zipping done! Uploading...");

            return s3client.putObject(new PutObjectRequest("docker-lambda", "fs/" + filename, new File("/tmp/" + filename))
                    .withCannedAcl(CannedAccessControlList.PublicRead));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static int runShell(String cmd) throws IOException, InterruptedException {
        Process process = Runtime.getRuntime().exec(new String[] { "sh", "-c", cmd });

        try (Scanner stdoutScanner = new Scanner(process.getInputStream());
                Scanner stderrScanner = new Scanner(process.getErrorStream())) {
            // Echo all stdout first
            while (stdoutScanner.hasNextLine()) {
                System.out.println(stdoutScanner.nextLine());
            }
            // Then echo stderr
            while (stderrScanner.hasNextLine()) {
                System.err.println(stderrScanner.nextLine());
            }
        }

        process.waitFor();
        return process.exitValue();
    }
}
