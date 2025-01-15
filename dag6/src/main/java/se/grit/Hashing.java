package se.grit;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class Hashing {

    private static final int SALT_LENGTH = 16;

    public static String hash(String str) {

        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);

        try {
            // Skapa en "digest"
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // Lägger till salten
            digest.update(salt);
            byte[] hashedString = digest.digest(str.getBytes());
            return byteArrayToHexString(hashedString) + byteArrayToHexString(salt);
        } catch(NoSuchAlgorithmException e) {
            return null;
        }
    }

    public static boolean Verify(String str, String result) {
        String hashedStr = result.substring(0, 64);
        String saltHex = result.substring(64);
        byte[] salt = hexStringToByteArray(saltHex);

        try {
            // Skapa en digest
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            // Lägg till salt
            digest.update(salt);
            byte[] hashString = digest.digest(str.getBytes());
            String hashStringHex = byteArrayToHexString(hashString);
            return hashedStr.equals(hashStringHex);
        } catch(NoSuchAlgorithmException e) {
            return false;
        }
    }

    private static String byteArrayToHexString(byte[] array) {
        StringBuilder sb = new StringBuilder();
        for(byte b : array) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    private static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[ len / 2];
        for(int i = 0; i < len; i += 2) {
            data[i/2] = (byte) ((Character.digit(s.charAt(i), 16) * 16) + (Character.digit(s.charAt(i+1), 16)));
        }
        return data;
    }

}
