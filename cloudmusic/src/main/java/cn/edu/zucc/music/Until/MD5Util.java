package cn.edu.zucc.music.Until;

import org.springframework.util.DigestUtils;


/**
 * @Author: hangzhouwh
 * @DATE: 2019/12/3
 * @MAIL: hangzhouwh@gmail.com
 */
public class MD5Util {

    // 盐值
    private static final String salt = "&%0308***&&%%$$#@";

    public static String getMD5(String str) {
        String base = str +"/"+salt;
        String md5 = DigestUtils.md5DigestAsHex(base.getBytes());
        return md5;
    }
}
