export const updateTitanicState = (state, obj) => {
	console.log("Debug")
	console.log(obj)
	if(obj.key == "survivalresult"){
		state.titanic.response = obj.value
	}else{
		console.log("Unhandled "+obj.value)
	}
}

export const resettitanic = (state) => {
	state.titanic.response = {}
}

export const loadingTitanic = (state, loading) => {
	state.titanic.loading = loading
}
