package cn.edu.zucc.advancejava.model;

public class Follow {
    private Integer id;

    private String fromUserid;

    private String toUserid;

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
}