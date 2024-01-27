import { Toaster } from "react-hot-toast"
import { RouterProvider } from "react-router-dom"
import router from "./routes/page"

function App() {

  return (
    <>
      <Toaster/>
      <RouterProvider router={router} />
    </>
  )
}

export default App
