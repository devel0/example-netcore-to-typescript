# example netcore to typescript

## description

shows how to setup [Reinforced Typings](https://github.com/reinforced/Reinforced.Typings) for netcore to typescript, useful for ef code-first types migrations across webapi to client side

## quickstart

```sh
git clone https://github.com/devel0/example-netcore-to-typescript
cd example-netcore-to-typescript/src
./gen-ts.sh
```

key notes:
- csproj must contains `<GenerateDocumentationFile>true</GenerateDocumentationFile>` in order to include documentation
- [src/ReinforcedTypingsFluent.cs](src/ReinforcedTypingsFluent.cs) allow customization of type generation

instantiate object example

```ts
const a = {
	create_timestamp: new Date.getUTCDate(),
	code: "some"
} as ISample;
```

## input

```cs
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Reinforced.Typings.Attributes;

namespace example_netcore_to_typescript
{

    [TsEnum]
    public enum MyStatus
    {
        Active,
        Completed,
        Waiting
    }

    [TsInterface]
    [Table("sample")]
    public class Sample
    {

        [Key]
        public int id { get; set; }

        /// <summary>
        /// UTC date of creation
        /// </summary>        
        public DateTime create_timestamp { get; set; }
        
        public string code { get; set; } 

        [TsIgnore]
        public string reserved_field { get; set; }

    }

}
```

## output

```ts
export enum MyStatus { 
	Active = 0, 
	Completed = 1, 
	Waiting = 2
}

export interface ISample
{
	id: number;
	/** UTC date of creation */
	create_timestamp: Date;
	code: string;
}

```

## how this project was built

```sh
mkdir -p example-netcore-to-typescript/src
cd example-netcore-to-typescript/src
dotnet new console -n example-netcore-to-typescript
dotnet add package Reinforced.Typings --version 1.5.6
cd ..
dotnet new sln
dotnet sln add src
dotnet build
```
