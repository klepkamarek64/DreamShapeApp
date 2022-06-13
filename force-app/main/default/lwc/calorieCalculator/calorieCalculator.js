import { LightningElement, wire } from 'lwc';
import calculateDiet from '@salesforce/apex/DietCalculatorController.calculateCaloricRequirement';
import makroDiet from '@salesforce/apex/DietCalculatorController.calculateMakroRequirement';


export default class CalorieCalculator extends LightningElement {

    get achieveRadioOptions() {
        return [
            {label:'I want to reduce my weight', value:'Reduce weight'},
            {label:'I want to keep my weight', value:'Keep weight'},
            {label:'I want to gain my weight', value:'Gain weight'}
        ];
    }

    achieveRadioChange(event) {
        this.achieve = event.detail.value;
    }
    
    get activityRadioOptions() {
        return [
            {label:'Low activity, sedentary lifestyle, no training session', value: 'Low activity'},
            {label:'Moderate activity, sedentary lifestyle, 2-4 training sessions per week. Right for most people.', value: 'Moderate activity'},
            {label:'Average activity, physical work or 3-4 training sessions with high intensity per week.', value: 'Average activity'},
            {label:'HiHigh activity, physical work or daily workouts with high intensity.', value: 'High activity'},
            {label:'Very high activity, physical work and daily workouts with high intensity.', value: 'Very high activity'}
        ];
    }

    activityRadioChange(event) {
        this.activity = event.detail.value;
    }
  
    get genderRadioOptions() {
        return [
             { label: 'Male', value: 'Man' },  
             { label: 'Female', value: 'Woman' }, 
            ];
    }

    genderRadioChange(event) {
        this.gender = event.detail.value;
    }

    weight;
    height;
    age;
    sum;
    error;
    gender;
    activity;
    achieve;

    isModalOpen = false;

    handleCalculateClick() {
        calculateDiet({weightCalc:this.weight, heightCalc:this.height, ageCalc:this.age, genderCalc:this.gender, achieveCalc:this.achieve, activityCalc:this.activity})
        .then(result =>{
            this.sum = result;
            this.openModal();
        })
        .catch(error=> {
            console.log('calculateDiet error');

            this.error = error;
        }) 
    }

    proteins;
    fats;
    carbs;

    isMakroModalOpen = false;

    handleMacroClick() {
        makroDiet({calculateCaloricRequirement:this.sum, weight:this.weight})
        .then(calculeteMakro =>{

            this.closeModal();
            this.openMakroModal();

            this.proteins = calculeteMakro[0];
            this.fats = calculeteMakro[1];
            this.carbs = calculeteMakro[2];
                
        })
        .catch(error => {
            console.log('makroDiet error');
        })

    }
    
    openModal() {
        this.isModalOpen = true;
    }
    submitDetails() {
        this.isModalOpen = false;
    }
    closeModal(){
        this.isModalOpen = false;
    }


    openMakroModal() {
        this.isMakroModalOpen = true;
    }
    submitMakroDetails() {
 
        this.isMakroModalOpen = false;
    }
    closeMakroModal() {
        this.isMakroModalOpen = false;
    }


    handleChange(event) {

        this.clickedButtonLabel = event.target.label;

        var inp=this.template.querySelectorAll("lightning-input");

        inp.forEach(function(element) {
            
            if(element.name == "weight") {
                this.weight = element.value;
            }
            else if(element.name == "height") {
                this.height = element.value;
            }
            else if(element.name == "age") {
                this.age= element.value;
            }
        },this);
    
    }
    
 }
        
    
    