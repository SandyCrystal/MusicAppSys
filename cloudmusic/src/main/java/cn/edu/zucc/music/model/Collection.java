package cn.edu.zucc.music.model;

import java.io.Serializable;

public class Collection implements Serializable {
    private Integer collectionId;

    private String userId;

    private String beCollectionedId;

    private Integer collectionType;

    private static final long serialVersionUID = 1L;

    public Integer getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(Integer collectionId) {
        this.collectionId = collectionId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getBeCollectionedId() {
        return beCollectionedId;
    }

    public void setBeCollectionedId(String beCollectionedId) {
        this.beCollectionedId = beCollectionedId == null ? null : beCollectionedId.trim();
    }

    public Integer getCollectionType() {
        return collectionType;
    }

    public void setCollectionType(Integer collectionType) {
        this.collectionType = collectionType;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", collectionId=").append(collectionId);
        sb.append(", userId=").append(userId);
        sb.append(", beCollectionedId=").append(beCollectionedId);
        sb.append(", collectionType=").append(collectionType);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}