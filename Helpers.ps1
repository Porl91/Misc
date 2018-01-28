# Dart
function CreateDartProjectOfType($name, $type) {
	switch($type) {
		'web' {
			$path = Join-Path -Path $name -ChildPath 'web'
			if (Test-Path($name)) {
				Write-Host "A folder with the name $name already exists" -ForegroundColor Red
				return
			}
			$mainFile = Join-Path -Path $path -ChildPath 'main.dart'
			$indexFile = Join-Path -Path $path -ChildPath 'index.html'
			$pubspecFile = Join-Path -Path $name -ChildPath 'pubspec.yaml'
			New-Item -ItemType Directory $path | Out-Null
			New-Item -ItemType File $mainFile | Out-Null
			New-Item -ItemType File $indexFile | Out-Null
			New-Item -ItemType File $pubspecFile | Out-Null
@"
import 'dart:html';

void main() {
	window.console.log('Hello, world!');
}
"@ | Out-File -FilePath $mainFile -Encoding UTF8

@"
name: $name
"@ | Out-File -FilePath $pubspecFile -Encoding UTF8

@"
<!doctype html/>
<html>
	<body>
		<script src="main.dart.js"></script>
	</body>
</html>
"@ | Out-File -FilePath $indexFile -Encoding UTF8

			Set-Location $name
			Write-Host "$name created as a $type project" -ForegroundColor Green
			break
		}
		default {
			Write-Host "$type is an invalid Dart project type" -ForegroundColor Red
		}
	}
}

Set-Alias dc CreateDartProjectOfType