/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Norttie
 */
public class Validator {

    public static boolean checkUsername(String username) {
        String regex = "^(?=.*[a-zA-Z])[a-zA-Z0-9]{5,10}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(username);
        return matcher.matches();
    }

    public static boolean checkPassWord(String passWord) {
        String regex = "^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{8,31}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(passWord);
        return matcher.matches();
    }

}
