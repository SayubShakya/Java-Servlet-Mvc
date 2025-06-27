package com.sayub;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.WebAppContext;

public class Application {
    public static void main(String[] args) throws Exception {
        Server server = new Server(9090);
        WebAppContext context = new WebAppContext();

        context.setContextPath("/");
        context.setResourceBase("src/main/webapp");
        // Include compiled classes for JSP support
        context.setAttribute("org.eclipse.jetty.server.webapp.ContainerIncludeJarPattern",
                ".*/classes/|.*/jar/.*|.*/target/classes/");

        // Required for JSPs
        context.setAttribute("javax.servlet.context.tempdir", new java.io.File("target/tmp"));
        context.setAttribute("org.apache.jasper.compiler.disablejsr199", true);
        context.setParentLoaderPriority(true);
        context.setConfigurationDiscovered(true);

        server.setHandler(context);
        server.start();
        server.join();
    }
}
