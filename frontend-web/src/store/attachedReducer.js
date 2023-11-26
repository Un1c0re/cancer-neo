const defaultState = {
    attached: 0,
}
export const attachedReducer = (state = defaultState, action) => {
    switch (action.type){
        case "CHANGE_VALUE_ATTACHED":
            return {...state, attached: action.payload}
        default:
            return state
    }
}