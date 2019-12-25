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