const defaultState = {
    patientId: "",
}
export const patientIdReducer = (state = defaultState, action) => {
    switch (action.type){
        case "CHANGE_VALUE_PATIENTID":
            return {...state, patientId: action.payload}
        default:
            return state
    }
}