<template>
	<div>
		<md-toolbar>
			  <h2 class="md-title" style="flex: 1">Titanic Simulation</h2>
		</md-toolbar>
		<md-toolbar class="md-accent">
			  <h2 class="md-title" style="flex: 1">Survival Score: {{ this.survivalscore }}</h2>
		</md-toolbar>
		<md-input-container>
			<label for="survived">Survived</label>
			<md-select name="survived" id="survived" v-model="survived">
				<md-option value="1">Survived</md-option>
				<md-option value="0">Died</md-option>
			</md-select>
		</md-input-container>		
		<md-input-container>
			<label for="ticketclass">Ticket Class</label>
			<md-select name="ticketclass" id="ticketclass" v-model="ticketclass">
				<md-option value="1">1st</md-option>
				<md-option value="2">2nd</md-option>
				<md-option value="3">3rd</md-option>
			</md-select>
		</md-input-container>
		<md-input-container>
			<label for="embarked">Embarked</label>
			<md-select name="embarked" id="embarked" v-model="embarked">
				<md-option value="C">Cherbourg</md-option>
				<md-option value="Q">Queenstown</md-option>
				<md-option value="S">Southampton</md-option>
			</md-select>
		</md-input-container>
		<md-input-container>
			<label for="sex">Sex</label>
			<md-select name="sex" id="sex" v-model="sex">
				<md-option value="M">Male</md-option>
				<md-option value="F">Female</md-option>
			</md-select>
		</md-input-container>
		<md-input-container>
			<label>Age</label>
			<md-input type="number" v-model="age"></md-input>
		</md-input-container>
		<md-input-container>
			<label>Parch</label>
			<md-input type="number" v-model="parch"></md-input>
		</md-input-container>
		<md-input-container>
			<label>sibsp</label>
			<md-input type="number" v-model="sibsp"></md-input>
		</md-input-container>
		<!--
		<md-input-container>
			<label>cabin</label>
			<md-input type="number" v-model="cabin"></md-input>
		</md-input-container>
		-->
		<md-input-container>
			<label>Fare</label>
			<md-input type="number" v-model="fare"></md-input>
		</md-input-container>
		<div>
			<md-button @click="makePrediction" class="md-raised md-primary" :disabled="predictiondisabled">Predict Survival</md-button>
			<md-button @click="reset" class="md-raised md-primary">Reset</md-button>
		</div>
	</div>
</template>

<script>
	//TODO Move this to actions once you have vuex working 
	import axios from 'axios'
	var url = "http://localhost:8181/titanic/"

	export default {
		name: 'titanic',
		data(){
			return {
				survived: '',
				ticketclass: '',
				embarked: '',
				sex: '',
				age: '',
				parch: '',
				sibsp: '',
				fare: '',
				predictiondisabled: false
			}
		},
		computed: {
			response(){
				return this.$store.getters.titanicresponse
			},
			survivalscore(){
				if(Object.keys(this.$store.getters.titanicresponse).length==0)
					return ''
				else
					return this.$store.getters.titanicresponse.Results.output1.value.Values[0][9]
			},
			url(){
				return this.$store.getters.titanicurl
			}
		},
		methods: {
			reset(){
				this.survived = ''
				this.ticketclass = ''
				this.embarked = ''
				this.sex = ''
				this.age = ''
				this.parch = ''
				this.sibsp = ''
				this.fare = ''

				this.$store.dispatch('resettitanic')	
			},
			makePrediction(){
				console.log("Clicked Make prediction")

				//Create Json from input 
				var obj = new Object()
				obj.Inputs = {}
				obj.Inputs.input1 = {}
				obj.Inputs.input1.ColumnNames = []
				obj.Inputs.input1.Values = []

				obj.Inputs.input1.ColumnNames.push("Survived", "Pclass", "Sex", "Age","SibSp", "Parch", "Fare", "Embarked")

				var input = []
				input.push(this.survived, this.ticketclass, this.sex, this.age, this.sibsp, this.parch, this.fare, this.embarked)
				
				//Add input
				obj.Inputs.input1.Values.push(input)

				var json = JSON.stringify(obj)

				this.$store.dispatch('titanicSurvivalPrediction', json)
			}
		},
		watch:{
			predictiondisabled(){
				if(this.survived=='' || this.ticketclass=='' || this.embarked=='' || this.sex=='' || this.age==''
					|| this.parch=='' || this.sibsp=='' || this.fare==''){
					return true
				}else{
					return false
				}
			}
		}
	/*computed: {
		ticketclass(){
			return this.$store.getters.ticketclass
		},
		embarked(){
			return this.$store.getters.embarked
		},
		sex(){
			return this.$store.getters.sex
		}
	}*/
}
</script>