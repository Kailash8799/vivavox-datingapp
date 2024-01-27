import { useCallback, useEffect, useState } from "react";
import { motion } from "framer-motion";
import { useNavigate, useSearchParams } from "react-router-dom";
import axios from "axios";
import toast from "react-hot-toast";

export default function EmailVerify() {

  const searchParams = useSearchParams();
  const [loading, setloading] = useState(false);
  const [disabled, setdisabled] = useState(true);
  const [mounted, setmounted] = useState(false);
  const [token, settoken] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    setmounted(true);
    settoken(searchParams[0]?.get("token") as string);

    if (token) {
      setdisabled(false);
    }
  }, [navigate, searchParams, token]);

  const verifyEmailAddress = useCallback(async () => {
    if (!mounted) return;
    setloading(true);
    try {
      const res = await axios({
        method: "post",
        url: `${
          import.meta.env.VITE_VIVAVOX_BACKEND
        }/v1/users/verifyemail/verify`,
        data: { token },
      });
      if (res?.status !== 200) {
        toast("Error occured!");
        setloading(false);
        return;
      }
      if (res?.data?.success) {
        toast("You can login now");
        navigate("/", { replace: true });
      } else {
        toast(res?.data?.message);
      }
      setloading(false);
      return;
    } catch (error) {
      toast("Some error accured!");
      setloading(false);
    }
  }, [mounted, navigate, token]);
  
  if (!mounted)
    return <div className="w-screen h-screen bg-white dark:bg-black"></div>;
  return (
    <>
      <div className="w-full h-full min-h-screen bg-white py-28 sm:py-32 sm:px-4 dark:bg-black">
        <div className="flex flex-col items-center justify-center">
          <motion.div
            initial={{ opacity: 0, scale: 0.5 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{
              duration: 0.8,
              delay: 0.5,
              ease: [0, 0.71, 0.2, 1.01],
            }}
            className="w-full p-10 rounded shadow bg-gradient-to-tl dark:from-slate-600 dark:to-black from-white to-slate-300 lg:w-1/3 md:w-1/2"
          >
            <p
              tabIndex={0}
              aria-label="Verify email address"
              className="text-2xl font-extrabold leading-6 text-gray-400 dark:text-gray-600"
            >
              Verify email address
            </p>

            <div className="flex items-center justify-between w-full py-5">
              <hr className="w-full bg-gray-400" />
            </div>
            <div className="mt-8">
              {loading ? (
                <button
                  aria-label="create my account"
                  className="items-center justify-center w-full py-2 text-xl font-bold leading-none text-center text-white transition-transform border rounded focus:ring-indigo-700 focus:outline-none dark:border-slate-700 bg-gradient-to-tl from-pink-500 to-blue-400 border-slate-200 hover:from-slate-500 hover:to-white"
                ></button>
              ) : (
                <button
                  disabled={disabled}
                  aria-label="create my account"
                  onClick={verifyEmailAddress}
                  className="relative
                  disabled:opacity-70
                  disabled:cursor-not-allowed
                  rounded-lg
                  hover:opacity-80
                  transition
                  w-full
                  bg-rose-500
                  border-rose-500
                  text-white
                  text-base
                  py-3
                  font-semibold
                  border-2"
                >
                  Verify email
                </button>
              )}
            </div>
          </motion.div>
        </div>
      </div>
    </>
  );
}