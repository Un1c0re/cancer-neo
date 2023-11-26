const defaultState = {
    patientName: "",
}
export const patientNameReducer = (state = defaultState, action) => {
    switch (action.type){
        case "CHANGE_VALUE_PATIENTNAME":
            return {...state, patientName: action.payload}
        default:
            return state
    }
}