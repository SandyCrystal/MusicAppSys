package cn.edu.zucc.music.model;

import java.io.Serializable;

public class Banner implements Serializable {
    private String pic;

    private String typetitle;

    private Integer targetid;

    private static final long serialVersionUID = 1L;

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public String getTypetitle() {
        return typetitle;
    }

    public void setTypetitle(String typetitle) {
        this.typetitle = typetitle == null ? null : typetitle.trim();
    }

    public Integer getTargetid() {
        return targetid;
    }

    public void setTargetid(Integer targetid) {
        this.targetid = targetid;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", pic=").append(pic);
        sb.append(", typetitle=").append(typetitle);
        sb.append(", targetid=").append(targetid);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}