import { createBrowserRouter } from "react-router-dom";
import Home from "../pages/home/page";
import EmailVerify from "../pages/verrifyuser/page";

const router = createBrowserRouter([
    {
        path: "/",
        id: "root",
        children: [
            {
                index: true,
                element: <Home />,
            },
            {
                path: "verifyemail",
                element: <EmailVerify />,
            },

        ],
    },
]);

export default router;