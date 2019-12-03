package cn.edu.zucc.music.Until;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


/**
 * @Author: hangzhouwh
 * @DATE: 2019/12/3
 * @MAIL: hangzhouwh@gmail.com
 */
public class JsonUtil {
//    public static void main(String[] args){
//        String str_fail = "{\"success\":false," +
//                "\"code\":\"image_repeated\"," +
//                "\"message\":\"Image upload repeated limit,this image exists at: https:\\/\\/i.loli.net\\/2019\\/12\\/03\\/6jevJzCrFomIEnN.jpg\"," +
//                "\"images\":\"https:\\/\\/i.loli.net\\/2019\\/12\\/03\\/6jevJzCrFomIEnN.jpg\"," +
//                "\"RequestId\":\"6C3B6774-6ED4-4F75-B1DF-8AF8CF4E81F9\"}";
//
//        String str_sucess = "{\"success\":true," +
//                "\"code\":\"success\"," +
//                "\"message\":\"Upload success.\"," +
//                "\"data\":{\"file_id\":0," +
//                "\"width\":200," +
//                "\"height\":200," +
//                "\"filename\":\"2.jpg\"," +
//                "\"storename\":\"pZmrNkoK2X4jvgB.jpg\"," +
//                "\"size\":9431," +
//                "\"path\":\"\\/2019\\/12\\/03\\/pZmrNkoK2X4jvgB.jpg\"," +
//                "\"hash\":\"puFafewNqGRHxm7WPQ38JLzUjY\"," +
//                "\"url\":\"https:\\/\\/i.loli.net\\/2019\\/12\\/03\\/pZmrNkoK2X4jvgB.jpg\"," +
//                "\"delete\":\"https:\\/\\/sm.ms\\/delete\\/puFafewNqGRHxm7WPQ38JLzUjY\"," +
//                "\"page\":\"https:\\/\\/sm.ms\\/image\\/pZmrNkoK2X4jvgB\"}," +
//                "\"RequestId\":\"9EB67A93-B7E2-4F14-B1F1-2EDA146A3DAE\"}";
//
//        JSONObject res = JsonUtil.stringToJson(str_fail);
//        String code = (String) res.get("code");
//        String picUrl = new String();
//        if (code.equals("success")){
//            JSONObject data = (JSONObject) res.get("data");
//            picUrl = (String) data.get("url");
//        }else if (code.equals("image_repeated")){
//            picUrl = (String) res.get("images");
//        }
//
//        System.out.println(picUrl);
//    }

    public static JSONObject stringToJson(String str) {
        System.out.println(str + "\n" + str.getClass());
        JSONObject jsonObj = new JSONObject();
        try {
            jsonObj = (JSONObject)(new JSONParser().parse(str));
            System.out.println(jsonObj.toJSONString() + "\n" + jsonObj.getClass());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return jsonObj;
    }
}
