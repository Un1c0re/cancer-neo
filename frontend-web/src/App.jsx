import {IndexPage, SearchPage, PatientPage} from "./pages/index.js";
import {BrowserRouter, Routes, Route} from 'react-router-dom'
const App = () => {
  return (
      <BrowserRouter>
        <Routes>
            <Route path="/" exact element={<IndexPage/>}/>
            <Route path="/search" element={<SearchPage/>}/>
            <Route path="/patient" element={<PatientPage/>}/>
        </Routes>
      </BrowserRouter>
  )
}

export default App
