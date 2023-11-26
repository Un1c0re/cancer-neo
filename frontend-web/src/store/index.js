import {combineReducers, createStore} from "redux";
import {composeWithDevTools} from "redux-devtools-extension";
import {doctorIdReducer} from "./doctorIdReducer.js";
import {patientIdReducer} from "./patientIdReducer.js";
import {patientNameReducer} from "./patientNameReducer.js";
import {attachedReducer} from "./attachedReducer.js";

const rootReducer = combineReducers({
    doctorId: doctorIdReducer,
    patientId: patientIdReducer,
    patientName: patientNameReducer,
    attached: attachedReducer
})
export const store = createStore(rootReducer, composeWithDevTools())