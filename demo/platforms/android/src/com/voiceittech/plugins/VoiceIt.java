package com.voiceittech.plugins;

import android.os.AsyncTask;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class VoiceIt {
    public String developerId;
    public String host;
    public String platformId;
    public String theResponse;
    public VoiceIt(String developerId) {
        this.developerId = developerId;
        this.platformId = "10";
        this.host = "https://siv.voiceprintportal.com/sivservice/api/";
    }

    private String GetSHA256(String data) {
        try {
            MessageDigest sha = MessageDigest.getInstance("SHA-256");
            sha.update(data.getBytes());
            byte[] hash = sha.digest();

            StringBuffer hexString = new StringBuffer();

            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1)
                    hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException ex) {
            throw new RuntimeException(ex);
        }
    }

    public String getUser(final String email,final String password){

        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"users");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String createUser(final String email,final String password,final String firstName, final String lastName){
        theResponse = "";
        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"users");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.setRequestMethod("POST");
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitFirstName", firstName);
                    urlConnection.addRequestProperty("VsitLastName", lastName);
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String setUser(final String email,final String password,final String firstName, final String lastName){
        theResponse = "";
        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"users");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.setRequestMethod("PUT");
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitFirstName", firstName);
                    urlConnection.addRequestProperty("VsitLastName", lastName);
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String deleteUser(final String email,final String password){
        theResponse = "";
        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"users");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.setRequestMethod("DELETE");
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String createEnrollment(final String email,final String password,final String pathToEnrollmentWav, final String contentLanguage){
        theResponse = "";
        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"enrollments");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.setRequestMethod("POST");
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    urlConnection.addRequestProperty("ContentLanguage", contentLanguage);
                    urlConnection.setRequestProperty("Content-Type", "audio/wav");
                    File file =  new File(pathToEnrollmentWav);
                    byte[] myData = new byte[(int) file.length()];
                    try {
                        FileInputStream fileInputStream = new FileInputStream(file);
                        fileInputStream.read(myData);
                        for (int i = 0; i < myData.length; i++) {
                            System.out.print((char)myData[i]);
                        }
                    } catch (FileNotFoundException e) {
                        System.out.println("File Not Found.");
                        e.printStackTrace();
                    }

                    DataOutputStream request = new DataOutputStream(urlConnection.getOutputStream());
                    request.write(myData);
                    request.flush();
                    request.close();
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String createEnrollmentByWavURL(final String email,final String password,final String urlToEnrollmentWav,final String contentLanguage){
        theResponse = "";
        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"enrollments/bywavurl");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.setRequestMethod("POST");
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    urlConnection.setRequestProperty("Content-Type", "audio/wav");
                    urlConnection.setRequestProperty("ContentLanguage", contentLanguage);
                    urlConnection.setRequestProperty("VsitwavURL", urlToEnrollmentWav);

                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String getEnrollments(final String email,final String password){

        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"enrollments");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setRequestMethod("GET");
                    urlConnection.setDoInput(true);
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String getEnrollmentCount(final String email,final String password, final String vppText){

        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"enrollments/count");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setRequestMethod("GET");
                    urlConnection.setDoInput(true);
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    urlConnection.addRequestProperty("VppText", vppText);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String deleteEnrollment(final String email,final String password,final String enrollmentId){

        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"enrollments"+"/"+enrollmentId);
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setRequestMethod("DELETE");
                    urlConnection.setDoInput(true);
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String authentication(final String email,final String password,final String pathToAuthenticationWav,final String accuracy, final String accuracyPasses, final String accuracyPassIncrement, final String confidence, final String contentLanguage){
        theResponse = "";
        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"authentications");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.setRequestMethod("POST");
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    urlConnection.addRequestProperty("VsitAccuracy", accuracy);
                    urlConnection.addRequestProperty("VsitAccuracyPasses", accuracyPasses);
                    urlConnection.addRequestProperty("VsitAccuracyPassIncrement", accuracyPassIncrement);
                    urlConnection.addRequestProperty("VsitConfidence", confidence);
                    urlConnection.addRequestProperty("ContentLanguage", contentLanguage);
                    urlConnection.setRequestProperty("Content-Type", "audio/wav");
                    File file =  new File(pathToAuthenticationWav);

                    byte[] myData = new byte[(int) file.length()];
                    try {
                        FileInputStream fileInputStream = new FileInputStream(file);
                        fileInputStream.read(myData);
                        for (int i = 0; i < myData.length; i++) {
                            System.out.print((char)myData[i]);
                        }
                    } catch (FileNotFoundException e) {
                        System.out.println("File Not Found.");
                        e.printStackTrace();
                    }

                    DataOutputStream request = new DataOutputStream(urlConnection.getOutputStream());
                    request.write(myData);
                    request.flush();
                    request.close();
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

    public String authenticationByWavURL(final String email,final String password,final String urlToAuthenticationWav,final String accuracy, final String accuracyPasses, final String accuracyPassIncrement, final String confidence, final String contentLanguage){
        theResponse = "";
        class RunAPICall extends AsyncTask<String, Void, String> {
            @Override
            protected String doInBackground(String... params) {
                try{
                    URL url = new URL(host+"authentications/bywavurl");
                    HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setDoInput(true);
                    urlConnection.setRequestMethod("POST");
                    urlConnection.addRequestProperty("PlatformID", platformId);
                    urlConnection.addRequestProperty("VsitEmail", email);
                    urlConnection.addRequestProperty("VsitPassword", GetSHA256(password));
                    urlConnection.addRequestProperty("VsitDeveloperId", developerId);
                    urlConnection.addRequestProperty("VsitAccuracy", accuracy);
                    urlConnection.addRequestProperty("VsitAccuracyPasses", accuracyPasses);
                    urlConnection.addRequestProperty("VsitAccuracyPassIncrement", accuracyPassIncrement);
                    urlConnection.addRequestProperty("VsitConfidence", confidence);
                    urlConnection.setRequestProperty("ContentLanguage", contentLanguage);
                    urlConnection.setRequestProperty("Content-Type", "audio/wav");
                    urlConnection.setRequestProperty("VsitwavURL", urlToAuthenticationWav);
                    String response = "";
                    try {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();
                        InputStream in;
                        if (urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            in = urlConnection.getInputStream();
                        }
                        else
                        {
                            in = urlConnection.getErrorStream();
                        }

                        int bytesRead = 0;
                        byte[] buffer = new byte[1024];
                        while ((bytesRead = in.read(buffer)) > 0) {
                            out.write(buffer, 0, bytesRead);
                        }
                        out.close();
                        response = new String(out.toByteArray());
                        theResponse = response;
                    } finally {
                        urlConnection.disconnect();
                    }

                }
                catch(IOException ioe)
                {
                    System.out.println("BACKGROUND FAILED");
                }
                return null;
            }
        }
        try {
            new RunAPICall().execute().get();
        }
        catch(Exception e)
        {
            return "{\"Result\":\"Internal Server Error\"}";
        }
        return theResponse;
    }

}
