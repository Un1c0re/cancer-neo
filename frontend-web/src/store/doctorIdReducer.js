const defaultState = {
    doctorId: "",
}
export const doctorIdReducer = (state = defaultState, action) => {
    switch (action.type){
        case "CHANGE_VALUE_DOCTORID":
            return {...state, doctorId: action.payload}
        default:
            return state
    }
}