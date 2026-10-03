// Fixed identity for the immutable Portico dependency fork. Build-time Git
// discovery would make the terminal version response depend on the checkout.
public enum SwiftTermBuildInfo {
    public static let branch: String? = "portico-1.19.0"
    public static let tag: String? = nil
    public static let commit: String? = nil
    public static let hasUncommittedChanges: Bool? = false
    public static let version = "1.19.0-portico"
}
