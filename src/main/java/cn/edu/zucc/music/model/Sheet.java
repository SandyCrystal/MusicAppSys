package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class Sheet implements Serializable {
    private String sheetId;

    private String userId;

    private String sheetName;

    private String picUrl;

    private Date createtime;

    private String copywriter;

    private Integer playconut;

    private static final long serialVersionUID = 1L;

    public String getSheetId() {
        return sheetId;
    }

    public void setSheetId(String sheetId) {
        this.sheetId = sheetId == null ? null : sheetId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getSheetName() {
        return sheetName;
    }

    public void setSheetName(String sheetName) {
        this.sheetName = sheetName == null ? null : sheetName.trim();
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl == null ? null : picUrl.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getCopywriter() {
        return copywriter;
    }

    public void setCopywriter(String copywriter) {
        this.copywriter = copywriter == null ? null : copywriter.trim();
    }

    public Integer getPlayconut() {
        return playconut;
    }

    public void setPlayconut(Integer playconut) {
        this.playconut = playconut;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", sheetId=").append(sheetId);
        sb.append(", userId=").append(userId);
        sb.append(", sheetName=").append(sheetName);
        sb.append(", picUrl=").append(picUrl);
        sb.append(", createtime=").append(createtime);
        sb.append(", copywriter=").append(copywriter);
        sb.append(", playconut=").append(playconut);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}