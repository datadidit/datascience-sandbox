package com.datadidit.azure;

import io.vertx.core.Vertx;
/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        Vertx.vertx().createHttpServer().requestHandler(req -> req.response().end("Hello World!")).listen(8080);
    }
}
