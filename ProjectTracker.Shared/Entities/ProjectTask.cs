﻿namespace ProjectTracker.Shared.Entities
{
    public class ProjectTask : BaseEntity
    {
        public int? ProjectId { get; set; }
        public Project? Project { get; set; }
        public DateTime Start { get; set; } = DateTime.Now;
        public DateTime? End { get; set; }
        public required User User { get; set; }
    }
}
