const Home = () => {
  return (
    <div className="bg-[url('/bg.svg')] h-dvh items-center justify-center flex">
      <div className="bg-[#FE3C72] inline-block p-3 rounded-lg">
        <a href="../../assets/app.apk" download={true} className="text-white font-bold">Download App</a>
      </div>
    </div>
  )
}

export default Home