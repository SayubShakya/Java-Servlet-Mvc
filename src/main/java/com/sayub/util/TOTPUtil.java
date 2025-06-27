package com.sayub.util;

import com.google.zxing.*;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import de.taimos.totp.TOTP;
import org.apache.commons.codec.binary.Base32;
import org.apache.commons.codec.binary.Hex;

import java.io.ByteArrayOutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

public class TOTPUtil {

    private static final String sec = "HUKPCNZMBZHQIXN4FTS3DE63ZMPJ3USD";

    // Generate a random Base32 secret key
    public static String generateSecretKey() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[20];
        random.nextBytes(bytes);
        Base32 base32 = new Base32();
        return base32.encodeToString(bytes);
    }

    // Generate TOTP code
    public static String getTOTPCode(String secretKey) {
        Base32 base32 = new Base32();
        byte[] bytes = base32.decode(secretKey);
        String hexKey = Hex.encodeHexString(bytes);
        return TOTP.getOTP(hexKey);
    }

    // Verify TOTP code
    public static boolean verifyCode(String secretKey, String userCode) {
        String generatedCode = getTOTPCode(secretKey);
        return generatedCode.equals(userCode);
    }

    // Generate QR Code URL
    public static String getQRBarcodeURL(String secretKey, String accountName, String issuer) {
        String encodedIssuer = URLEncoder.encode(issuer, StandardCharsets.UTF_8);
        String encodedAccount = URLEncoder.encode(accountName, StandardCharsets.UTF_8);
        return String.format(
            "otpauth://totp/%s?secret=%s&issuer=%s",
            encodedIssuer + ":" + encodedAccount, secretKey, encodedIssuer
        );
    }

    // Generate QR Code image as Base64
    public static String getQRCodeImageBase64(String qrCodeURL, int width, int height) throws Exception {
        BitMatrix matrix = new MultiFormatWriter().encode(qrCodeURL, BarcodeFormat.QR_CODE, width, height);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(matrix, "PNG", baos);
        return Base64.getEncoder().encodeToString(baos.toByteArray());
    }

    // Sample usage
    public static void main(String[] args) throws Exception {
        String secretKey = generateSecretKey();
        System.out.println("Secret Key: " + secretKey);

        String qrUrl = getQRBarcodeURL(sec, "sayub@example.com", "SayubApp");
        String base64QR = getQRCodeImageBase64(qrUrl, 300, 300);
        System.out.println("Base64 Encoded QR:\n" + base64QR);

        while(true) {
            String code = getTOTPCode(sec);
            System.out.println("Generated TOTP Code: " + code);
            try {
                Thread.sleep(1000);
            }catch (Exception e) {
                e.printStackTrace();
            }
        }


//        boolean isValid = verifyCode(sec, code);
//        System.out.println("Is code valid? " + isValid);
    }
}
