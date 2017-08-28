export const updateTitanicState = (state, obj) => {
	console.log("Got an object")
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
