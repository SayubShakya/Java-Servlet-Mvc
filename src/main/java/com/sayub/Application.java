package com.sayub;

import io.github.cdimascio.dotenv.Dotenv;
import io.github.cdimascio.dotenv.DotenvEntry;
import org.eclipse.jetty.ee10.webapp.WebAppContext;
import org.eclipse.jetty.server.Server;

public class Application {
    public static void main(String[] args) throws Exception {

        loadEnv();

        Server server = new Server(Integer.parseInt(System.getProperty("APPLICATION_PORT", "9090")));
        WebAppContext context = new WebAppContext();
        context.setWar("target/root.war");
        context.setContextPath("/");
        context.setAttribute("org.eclipse.jetty.server.webapp.ContainerIncludeJarPattern", ".*/classes/|.*/jar/.*|.*/target/classes/");

        // Required for JSPs
        context.setAttribute("javax.servlet.context.tempdir", new java.io.File("target/tmp"));
        context.setAttribute("org.apache.jasper.compiler.disablejsr199", true);
        context.setParentLoaderPriority(true);
        context.setConfigurationDiscovered(true);

        server.setHandler(context);
        server.start();
        server.join();
    }

    private static void loadEnv() {
        Dotenv dotenv = Dotenv.load();

        for (DotenvEntry entry : dotenv.entries()) {
            System.setProperty(entry.getKey(), entry.getValue());
        }
    }
}