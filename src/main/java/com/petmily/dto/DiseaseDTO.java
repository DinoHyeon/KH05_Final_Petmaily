package com.petmily.dto;

public class DiseaseDTO {

   private int num;
   private String disease_name;
   private String animal;
   private String define;
   private String condition;
   
   public int getNum() {
      return num;
   }
   public void setNum(int num) {
      this.num = num;
   }
   public String getDisease_name() {
      return disease_name;
   }
   public void setDisease_name(String disease_name) {
      this.disease_name = disease_name;
   }
   public String getAnimal() {
      return animal;
   }
   public void setAnimal(String animal) {
      this.animal = animal;
   }
   public String getDefine() {
      return define;
   }
   public void setDefine(String define) {
      this.define = define;
   }
   public String getCondition() {
      return condition;
   }
   public void setCondition(String condition) {
      this.condition = condition;
   }
}