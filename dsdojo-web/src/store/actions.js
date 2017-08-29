import axios from 'axios'

export const titanicSurvivalPrediction = ({commit, getters}, json) => {
	var url = getters.titanicurl 

	commit('loadingTitanic', true)

	axios.post(url, json, {
		headers: {
			'Content-Type': "application/json",
			'Access-Control-Allow-Origin': '*'
		}
	})
	.then(function(response){
		var obj = new Object()
		obj.key = "survivalresult"
		obj.value = response.data
		
		commit('updateTitanicState', obj)
		commit('loadingTitanic', false);
	})
	.catch(function(error){
		console.log(error)
	})
}

export const resettitanic = ({ commit }) => commit('resettitanic')