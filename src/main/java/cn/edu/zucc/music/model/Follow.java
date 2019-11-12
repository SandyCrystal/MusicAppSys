package cn.edu.zucc.music.model;

import java.io.Serializable;

public class Follow implements Serializable {
    private Integer id;

    private String fromUserid;

    private String toUserid;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFromUserid() {
        return fromUserid;
    }

    public void setFromUserid(String fromUserid) {
        this.fromUserid = fromUserid == null ? null : fromUserid.trim();
    }

    public String getToUserid() {
        return toUserid;
    }

    public void setToUserid(String toUserid) {
        this.toUserid = toUserid == null ? null : toUserid.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", fromUserid=").append(fromUserid);
        sb.append(", toUserid=").append(toUserid);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}