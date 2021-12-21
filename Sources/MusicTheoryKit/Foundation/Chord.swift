//
//  Chord.swift
//  MusicTheoryKit
//
//  Created by Jin Zhang on 12/13/21.
//

/// A custom musical chord.
///
/// As someone familiar with music theory might expect, a custom chord has its component notes and a root note. The chord's quality is determined by these notes.
/// Create a chord by using it's name directly is the most conveinient way!
/// ```swift
/// let myChord = Chord("Cmaj9/G")!
/// print(myChord.description)
/// // This is a slash chord named Cmaj9/G over G, with root note C,
/// // and component notes D, E, G, B, which are respectively major second,
/// // major third, perfect fifth, major seventh above the root.
/// ```
public struct Chord : CustomStringConvertible {
    /// Create a chord based on its component notes and the root note. Optionally, specify a slash root if it's a slash chord.
    ///
    /// ```swift
    /// let chord = Chord(root: .F, notes: Set([.F, .G, .C]), slash: .Bb)
    /// ```
    /// For full reference of available chords, go to <doc:Chords-Reference>
    public init?(root: Note, notes: Set<Note>, slash: Note? = nil) {
        var intervals = [Interval]()
        for note in notes {
            if (note == root || note == slash) { continue }
            intervals.append(note - root)
        }
        intervals.sort()
        guard let quality = semitonesToQuality[intervals] else { return nil }
        
        self.root = root
        self.notes = notes
        if slash == root { self.slash = nil } else { self.slash = slash }
        self.intervals = intervals
        self.quality = quality
    }
    /// Create a chord directly from it's name.
    ///
    /// ```swift
    /// let chord = Chord("Cmaj9/G")
    /// ```
    /// For full reference of available chords, go to <doc:Chords-Reference>
    public init?(_ name: String) {
        let splitedName = name.split(separator: "/", omittingEmptySubsequences: false)
        guard splitedName.count == 1 || splitedName.count == 2 else { return nil }
        guard !splitedName.contains("") else { return nil }
        var rootAndQuality = String(splitedName[splitedName.startIndex])
        var root = String(rootAndQuality.removeFirst())
        if rootAndQuality.count > 1 && rootAndQuality[rootAndQuality.startIndex] == "b" {
            root += String(rootAndQuality[rootAndQuality.startIndex])
            rootAndQuality.remove(at: rootAndQuality.startIndex)
        }
        let quality = rootAndQuality
        let slash = splitedName.count == 2 ? String(splitedName[splitedName.index(splitedName.startIndex, offsetBy: 1)]) : nil
        self.init(root, quality, over: slash)
    }
    /// The root of this chord.
    public let root: Note
    /// Set of notes in the chord.
    public let notes: Set<Note>
    /// The note this chord is over.
    public let slash: Note?
    /// The name of a chord.
    ///
    /// The following code generate a chord with name "Esus4"
    /// ```swift
    /// let root: Note = .E
    /// let notes: Set<Note> = Set([.E, .A, .B])
    /// let chord = Chord(root: root, notes: notes)?
    /// ```
    public var name: String {
        if let slash = slash {
            return root.rawValue + quality + "/" + slash.rawValue
        } else {
            return root.rawValue + quality
        }
    }
    /// Describe the chord.
    public var description: String {
        let ifSlashDescription = slash != nil ? " slash" : ""
        let slashDescription = slash != nil ? " over \(slash!.rawValue)" : ""
        let notesDescription = intervals.map{ (root + $0).rawValue }.joined(separator: ", ")
        let intervalsDescription = intervals.map{ $0.wholeName }.joined(separator: ", ")
        
        return "This is a\(ifSlashDescription) chord named \(name)\(slashDescription), with root note \(root), and component notes \(notesDescription), which are respectively \(intervalsDescription) above the root."
    }
    //------------------- Not Part of API --------------------------//
    private init?(_ root: String, _ quality: String, over slash: String? = nil) {
        guard let root = Note(rawValue: root) else { return nil }
        guard let intervals = semitonesToQuality.first(where: { $1 == quality })?.key else { return nil }
        if let slash = slash { guard Note(rawValue: slash) != nil else { return nil } }
        let notes = intervals.map{ root + $0 }
        let doNotCreateSlash = slash == nil || Note(rawValue: slash!) == root
        
        self.notes = Set(notes)
        self.root = root
        self.slash = doNotCreateSlash ? nil : Note(rawValue: slash!)!
        self.intervals = intervals
        self.quality = quality
    }
    private let intervals: [Interval]
    private let quality: String
}
