if [ "$1" == "" ];then
    echo "need a project name"
    exit
fi
npx create-next-app $1 --ts --app
cd $1
rm -r public/*
rm -r app/*
rm -r src/*
rm README.md
mkdir src/styles
mkdir src/app
# mkdir components

echo "*{margin:0;padding:0;box-sizing:none;}body,html{max-width:100vw;}a{text-decoration:none;color:inherit;}" > src/styles/globals.scss
prettier -w src/styles/globals.scss #> /dev/null

echo 'import "@/styles/globals.scss"

export const metadata = { //TODO: metadata
	title: "next app",
	description: "Hey description",
}

export default function RootLayout({
	children,
}: {
	children: React.ReactNode
}) {
	return (
		<html>
			<body>
				<main>{children}</main>
			</body>
		</html>
	)
}
' > src/app/layout.tsx
echo 'export default function Home() {
  return (
    <>
    <h1>CONTENT HERE</h1>
    </>
  )
}' > src/app/page.tsx

prettier -w src/app/*

npm i sass

echo "Next app created and cleaned up :)"
