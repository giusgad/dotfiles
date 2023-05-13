if [ "$1" == "" ];then
    echo "need a project name"
    exit
fi
npx create-next-app $1 --ts --app
cd $1
rm -r public/*
rm -r app/*
rm README.md
mkdir styles
mkdir components

echo "*{margin:0;padding:0;box-sizing:none;}body,html{max-width:100vw;}a{text-decoration:none;color:inherit;}" > styles/globals.scss
prettier -w styles/globals.scss #> /dev/null

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
' > app/layout.tsx
echo 'export default function Home() {
  return (
    <>
    <h1>CONTENT HERE</h1>
    </>
  )
}' > app/page.tsx

prettier -w app/*

npm i sass

echo "\nNext app created and cleaned up :)"
