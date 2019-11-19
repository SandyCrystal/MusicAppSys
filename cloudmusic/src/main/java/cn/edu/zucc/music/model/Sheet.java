package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class Sheet implements Serializable {
    private String sheetId;

    private String sheetName;

    private String userId;

    private String userName;

    private String sheetPicUrl;

    private Date createTime;

    private Integer sheetType;

    private Integer playCount;

    private static final long serialVersionUID = 1L;

    public String getSheetId() {
        return sheetId;
    }

    public void setSheetId(String sheetId) {
        this.sheetId = sheetId == null ? null : sheetId.trim();
    }

    public String getSheetName() {
        return sheetName;
    }

    public void setSheetName(String sheetName) {
        this.sheetName = sheetName == null ? null : sheetName.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getSheetPicUrl() {
        return sheetPicUrl;
    }

    public void setSheetPicUrl(String sheetPicUrl) {
        this.sheetPicUrl = sheetPicUrl == null ? null : sheetPicUrl.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getSheetType() {
        return sheetType;
    }

    public void setSheetType(Integer sheetType) {
        this.sheetType = sheetType;
    }

    public Integer getPlayCount() {
        return playCount;
    }

    public void setPlayCount(Integer playCount) {
        this.playCount = playCount;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", sheetId=").append(sheetId);
        sb.append(", sheetName=").append(sheetName);
        sb.append(", userId=").append(userId);
        sb.append(", userName=").append(userName);
        sb.append(", sheetPicUrl=").append(sheetPicUrl);
        sb.append(", createTime=").append(createTime);
        sb.append(", sheetType=").append(sheetType);
        sb.append(", playCount=").append(playCount);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}