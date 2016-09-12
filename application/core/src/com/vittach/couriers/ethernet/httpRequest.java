package com.vittach.couriers.ethernet;

import java.util.Map;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Net;
import com.badlogic.gdx.net.HttpParametersUtils;

public class httpRequest {
    public String urlSite;
    private boolean getResponseFlag;
    private Net.HttpRequest httpGet;
    private String response,cookieString,sessID;

    public httpRequest(String url) {
        urlSite = url;
    }

    public String sendRequest(Map prm, String param){

        if(param.equals("GET"))
            httpGet = new Net.HttpRequest(Net.HttpMethods. GET);
        else if(param.equals("POST"))
            httpGet = new Net.HttpRequest(Net.HttpMethods.POST);

        httpGet.setUrl(urlSite);
        if (sessID != null)
        httpGet.setHeader("Cookie","laravel_session=" + sessID);
        httpGet.setContent(HttpParametersUtils.convertHttpParameters(prm));

        Gdx.net.sendHttpRequest (httpGet, new Net.HttpResponseListener() {
            public void handleHttpResponse(Net.HttpResponse httpResponse){
                response = httpResponse.getResultAsString();
                cookieString = httpResponse.getHeader("Set-Cookie");
                if (cookieString!=null)
                {
                    String[]keyValPairs = cookieString.split("; ?");
                    for (String encodedPair : keyValPairs) {
                        String keyVal[] = encodedPair.split("=");
                        if (keyVal[0].equalsIgnoreCase("laravel_session"))
                            sessID = keyVal[1];
                    }
                }
                getResponseFlag = true;
            }

            public void failed(Throwable exp) {
                response = "failed";
                getResponseFlag = true;
            }

            @Override public void cancelled() {
                response = "cancelled";
                getResponseFlag = true;
            }
        });
        while(getResponseFlag == false);
        getResponseFlag = false;
        return response;
    }
}
